const UserServices = require('../services/user.service');

exports.register = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        const duplicate = await UserServices.getUserByEmail(email);
        if (duplicate) {
            return res.json({ status: false, message: `Email ${email} đã được đăng ký!` });
        }

        await UserServices.registerUser(email, password);
        res.json({ status: true, success: 'User registered successfully' });
    } catch (err) {
        console.error("---> Register Error:", err);
        next(err);
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.json({ status: false, message: 'Vui lòng nhập đầy đủ email và mật khẩu' });
        }

        let user = await UserServices.checkUser(email);
        if (!user) {
            return res.json({ status: false, message: 'Email hoặc mật khẩu không đúng' });
        }

        const isPasswordCorrect = await user.comparePassword(password);
        if (!isPasswordCorrect) {
            return res.json({ status: false, message: 'Email hoặc mật khẩu không đúng' });
        }

        const tokenData = { _id: user._id, email: user.email };
        const token = await UserServices.generateAccessToken(tokenData, "YOUR_SECRET_KEY", "1h");
        res.json({ status: true, token: token });
    } catch (error) {
        console.error("---> Login Error:", error);
        next(error);
    }
}