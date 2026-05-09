const router = require("express").Router();
const ToDoController = require('../controller/todo.controller');

// Đăng ký Task mới
router.post("/storeTodo", ToDoController.createToDo); 

// Lấy danh sách Task (Đổi từ GET sang POST để nhận userId từ body)
router.post('/getUserTodoList', ToDoController.getToDoList);

// Xóa Task
router.post("/deleteTodo", ToDoController.deleteToDo);

module.exports = router;