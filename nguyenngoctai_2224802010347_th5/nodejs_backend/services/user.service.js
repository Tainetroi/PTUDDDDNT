const UserModel = require("../models/user.model");
const jwt = require("jsonwebtoken");

class UserServices {
    
    // Đăng ký người dùng mới
    static async registerUser(email, password) {
        try {
            // Mật khẩu sẽ tự động được băm nhờ pre-save hook trong UserModel
            const createUser = new UserModel({ email, password });
            return await createUser.save();
        } catch (err) {
            throw err;
        }
    }

    // Tìm kiếm người dùng theo email (Dùng chung cho cả check trùng và login)
    static async getUserByEmail(email) {
        try {
            return await UserModel.findOne({ email });
        } catch (err) {
            throw err; 
        }
    }

    // Kiểm tra user tồn tại (Có thể dùng alias hoặc gọi lại getUserByEmail)
    static async checkUser(email) {
        return await this.getUserByEmail(email);
    }

    // Tạo JWT Token cho phiên đăng nhập
    static async generateAccessToken(tokenData, JWTSecret_Key, JWT_EXPIRE) {
        // tokenData thường chứa { _id: user._id, email: user.email }
        return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
    }
}

module.exports = UserServices;