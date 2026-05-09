const app = require("./app");
const mongoose = require('mongoose');

const uri = 'Đây là link mongoDB do vấn đề cần bảo mật nên sẽ tạm thời bị xóa';

const port = 5000;

mongoose.connect(uri)
  .then(() => {
    console.log('✅ MongoDB Atlas Connected Successfully');
    app.listen(port, () => {
      console.log(`🚀 Server Listening on Port http://localhost:${port}`);
    });
  })
  .catch((error) => {
    console.log('❌ MongoDB Atlas Connection error:', error);
  });
