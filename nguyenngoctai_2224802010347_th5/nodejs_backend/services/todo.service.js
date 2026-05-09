const ToDoModel = require("../models/todo.model");

class ToDoService {
    // Thống nhất dùng biến 'desc' để khớp với Flutter và Controller
    static async createToDo(userId, title, desc) {
        // Sử dụng Shorthand property: {userId, title, desc}
        const createToDo = new ToDoModel({ userId, title, desc });
        return await createToDo.save();
    }

    static async getUserToDoList(userId) {
        // Truy vấn tất cả task của 1 user và sắp xếp mới nhất lên đầu
        return await ToDoModel.find({ userId }).sort({ createdAt: -1 });
    }

    static async deleteToDo(id) {
        // Xóa dựa trên ID của tài liệu (Document ID)
        return await ToDoModel.findByIdAndDelete(id);
    }
}

module.exports = ToDoService;