const app = require("./app");
const mongoose = require('mongoose');

const uri = 'mongodb+srv://ngocngoctaicm_db_user:kzcDlwGintNyTASc@cluster0.dznphxw.mongodb.net/ToDoDB?retryWrites=true&w=majority';

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