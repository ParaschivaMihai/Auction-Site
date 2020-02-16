const express = require('express');
const bodyParser = require('body-parser');
const routeControler = require('./controler/routeControler');



const app = express();
//parser pentru post request
const urlencodedParser = bodyParser.urlencoded({extended:false})
app.use(bodyParser.urlencoded({extended: false}))
//seteaza folderul de unde sa obtine asseturile 
app.use('/assets',express.static('assets'));
//activeza motorul radnarea a templateurilor
app.set('view engine', 'ejs');

routeControler(app,urlencodedParser);
app.listen(3000);
console.log('listening to the port 3000');


