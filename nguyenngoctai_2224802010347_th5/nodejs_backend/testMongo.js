const mongoose = require('mongoose');
const connection = require('./config/db');

const testSchema = new mongoose.Schema({
  name: String,
  timestamp: Date
});

const TestModel = connection.model('test_connection', testSchema);

const runTest = async () => {
  try {
    console.log('🔄 Đang kết nối MongoDB...');

    if (connection.readyState === 1) {
      console.log('✅ Kết nối MongoDB đã mở ngay lập tức');
    }

    connection.once('open', async () => {
      console.log('✅ Kết nối MongoDB thành công!');
      console.log(`📚 Database: ${connection.name}`);

      const newDoc = await TestModel.create({
        name: 'Test Document',
        timestamp: new Date()
      });

      console.log('✅ Insert document thành công:', newDoc);

      await TestModel.deleteOne({ _id: newDoc._id });
      console.log('🗑️  Xóa test document');

      await connection.close();
      console.log('👋 Ngắt kết nối MongoDB');
      process.exit(0);
    });
  } catch (error) {
    console.error('❌ Lỗi kết nối:', error.message);
    console.error('📌 Chi tiết:', error);
    process.exit(1);
  }
};

connection.on('error', (error) => {
  console.error('❌ MongoDB Connection error:', error.message);
  console.error('📌 Chi tiết:', error);
  process.exit(1);
});

runTest();
