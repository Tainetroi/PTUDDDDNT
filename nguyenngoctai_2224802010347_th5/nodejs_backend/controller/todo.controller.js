const ToDoService = require('../services/todo.service');

exports.createToDo = async (req, res, next) => {
    try {
        const { userId, title, desc } = req.body;

        // Kiểm tra dữ liệu đầu vào cơ bản (Validation)
        if (!userId || !title) {
            return res.status(400).json({ status: false, message: "Missing required fields" });
        }

        let todoData = await ToDoService.createToDo(userId, title, desc);
        
        // Trả về 201 cho hành động tạo mới
        res.status(201).json({ status: true, success: todoData });
    } catch (error) {
        console.error('Error in createToDo:', error);
        next(error);
    }
}

exports.getToDoList = async (req, res, next) => {
    try {
        const { userId } = req.body;

        if (!userId) {
            return res.status(400).json({ status: false, message: "User ID is required" });
        }

        let todoData = await ToDoService.getUserToDoList(userId);
        res.json({ status: true, success: todoData });
    } catch (error) {
        console.error('Error in getToDoList:', error);
        next(error);
    }
}

exports.deleteToDo = async (req, res, next) => {
    try {
        const { id } = req.body;

        if (!id) {
            return res.status(400).json({ status: false, message: "Todo ID is required" });
        }

        let deletedData = await ToDoService.deleteToDo(id);
        
        // Trả về thông báo rõ ràng hơn
        res.json({ status: true, success: deletedData });
    } catch (error) {
        console.error('Error in deleteToDo:', error);
        next(error);
    }
}