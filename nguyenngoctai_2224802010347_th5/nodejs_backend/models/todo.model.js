const db = require('../config/db');
const UserModel = require("./user.model");
const mongoose = require('mongoose');
const { Schema } = mongoose;

const toDoSchema = new Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref: UserModel.modelName,
        required: true // Nên thêm required để đảm bảo mọi task đều có chủ sở hữu
    },
    title: {
        type: String,
        required: true,
        trim: true // Tự động xóa khoảng trắng thừa ở 2 đầu
    },
    desc: { // Đổi từ 'description' thành 'desc' để khớp với req.body phía Controller
        type: String,
        required: true
    },
}, { timestamps: true });

// Sắp xếp mặc định: Task mới nhất lên đầu
toDoSchema.index({ createdAt: -1 });

const ToDoModel = db.model('todo', toDoSchema);
module.exports = ToDoModel;