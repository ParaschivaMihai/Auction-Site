const mysql = require('mysql');
const con = mysql.createConnection({
    host:"localhost",
    user: "root",
    password: "1234",
    database: 'site_licitati'
});

let connect = false;
let connect2 = false;
let username;
let lastvalue = 2500;
let lastvalue2 = 1000;

//creez conexiunea cu mysql
con.connect(function(err){
    if(err) throw err;
    console.log("MySql is connected!");
});

//creez modulul care se va ocupa de toate url-urile
module.exports = function(app, urlencodedParser){
    app.get('/',function(req, res){
        if(connect){
            let qr = `select id_telefon, imagine, descriere, pret_initial, nume_model `+
                     `from telefon join model_telefon `+
                     `on telefon.id_model = model_telefon.id_model ` +
                     `join status on status.id_status = telefon.status_telefon ` +
                     `where status.nume_status = 'in licitatie' and telefon.pret_initial > 1000`
            
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('mainpage',{data:result, lastvalue:lastvalue2});
                console.log(result);
            });
        }else{
            res.redirect('http://localhost:3000/login')
        }
    })

    app.post('/',urlencodedParser,function(req,res){
        let data = req.body;
        let qr =  `select id_telefon, imagine, descriere, pret_initial, nume_model `+
        `from telefon join model_telefon `+
        `on telefon.id_model = model_telefon.id_model ` +
        `join status on status.id_status = telefon.status_telefon ` +
        `where status.nume_status = 'in licitatie' and telefon.pret_initial > ${data.valoare}`
        
        con.query(qr, function (err, result) {
            if (err) throw err;
            lastvalue2 = data.valoare;
            res.render('mainpage',{data:result, lastvalue:lastvalue2});
        });
    })


    app.get('/login',function(req, res){
        res.render('Login');
    });

    app.post('/login',urlencodedParser,function(req, res){
        let qr = `select mail `+
                 `from users `+
                 `where mail = '${req.body.mail}' and parola = '${req.body.parola}'`;
        
         con.query(qr, function (err, result) {
            if (err) throw err;
            console.log(result);
            if(result.length != 0 && result[0].mail == req.body.mail){
                username = req.body.mail;
                connect = true;
                res.redirect('http://localhost:3000');
                }else{
                    res.render('login');
                }
        });
    });

    app.get('/admin',function(req, res){
        res.render('loginAdmin');
    });

    app.post('/admin',urlencodedParser,function(req, res){
        let qr = `select nume_admin `+
                 `from admin `+
                 `where nume_admin = '${req.body.mail}' and parola = '${req.body.parola}'`;
        
        con.query(qr, function (err, result) {
            if (err) throw err;
            console.log(result);
            if(result.length != 0 && result[0].nume_admin == req.body.mail){
                username = req.body.mail;
                connect2 = true;
                res.redirect('http://localhost:3000/adminPage');
                }else{
                    res.render('loginAdmin');
                }
        });
    });

    app.get('/adminPage',function(req,res){
        if(connect2){
            let qr = `select p.nume as nume_proprietar, p.prenume as prenume_prorietar, c.nume as cumparator_nume , c.prenume as cumparator_prenume, oferta `+
            `from licitatie l `+
            `join telefon t on t.id_telefon = l.id_telefon ` +
            `join users p on p.id_user = t.id_proprietar ` +
            `join users c on l.id_cumparator = c.id_user`
   
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('adminPage',{nume:username, data:result});
            });
        }else{
            res.render('loginAdmin');
        }
    });

    app.get('/adminPage/topModel',function(req,res){
        if(connect2){
            let qr = `select nume_model, count(id_telefon) as numar `+
            `from telefon `+
            `join model_telefon on model_telefon.id_model = telefon.id_model ` +
            `group by model_telefon.id_model ` +
            `order by numar desc`
   
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('adminPage',{nume:username, data:result});
            });
        }else{
            res.render('loginAdmin');
        }
    });

    app.get('/adminPage/topVanzator',function(req,res){
        if(connect2){
            let qr = `select nume, prenume, count(id_telefon) as nr `+
            `from users `+
            `join telefon on users.id_user = telefon.id_proprietar ` +
            `group by id_user ` +
            `order by nr desc`
   
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('adminPage',{nume:username, data:result});
            });
        }else{
            res.render('loginAdmin');
        }
    });

    app.get('/adminPage/telefonRecent',function(req,res){
        if(connect2){
            let qr = `select model_telefon.nume_model, telefon.data_cumparare `+
            `from telefon `+
            `join model_telefon on model_telefon.id_model = telefon.id_model ` +
            `where telefon.data_cumparare in (select max(t2.data_cumparare) from telefon t2 group by t2.id_model) ` ;
   
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('adminPage',{nume:username, data:result});
            });
        }else{
            res.render('loginAdmin');
        }
    });

    app.get('/adminPage/castigatorLicitatie',function(req,res){
        if(connect2){
            let qr = `select p.nume as nume_proprietar, p.prenume as prenume_prorietar, c.nume as cumparator_nume , c.prenume as cumparator_prenume, oferta `+
            `from licitatie l `+
            `join telefon t on t.id_telefon = l.id_telefon ` +
            `join users p on p.id_user = t.id_proprietar ` +
            `join users c on l.id_cumparator = c.id_user ` +
            `where l.oferta in (select max(l2.oferta) from licitatie l2 group by l2.id_telefon ) `;
   
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('adminPage',{nume:username, data:result});
            });
        }else{
            res.render('loginAdmin');
        }
    });

    app.get('/adminPage/peste2500',function(req,res){
        if(connect2){
            let qr = `select p.nume, p.prenume, m.nume_model, t.pret_initial as pret `+
            `from telefon t `+
            `join users p on p.id_user = t.id_proprietar ` +
            `join model_telefon m on m.id_model = t.id_model ` +
            `where t.pret_initial in (select t2.pret_initial from telefon t2 where t2.pret_initial > 2500) ` +
            `order by pret desc `;
   
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('adminPage2',{nume:username, data:result, lastvalue:lastvalue});
            });
        }else{
            res.render('loginAdmin');
        }
    });


    app.post('/adminPage/peste2500',urlencodedParser,function(req,res){
        let data = req.body;
        let qr = `select p.nume, p.prenume, m.nume_model, t.pret_initial as pret `+
        `from telefon t `+
        `join users p on p.id_user = t.id_proprietar ` +
        `join model_telefon m on m.id_model = t.id_model ` +
        `where t.pret_initial in (select t2.pret_initial from telefon t2 where t2.pret_initial > ${data.valoare}) ` +
        `order by pret desc `;
        
        con.query(qr, function (err, result) {
            if (err) throw err;
            lastvalue = data.valoare;
            res.render('adminPage2',{nume:username, data:result, lastvalue:lastvalue});
        });
    })

    app.get('/adminPage/nelicitate',function(req,res){
        if(connect2){
            let qr = `select p.nume, p.prenume, m.nume_model `+
            `from users p `+
            `join telefon t on t.id_proprietar = p.id_user ` +
            `join model_telefon m on m.id_model = t.id_model ` +
            `where t.id_telefon not in (select l.id_telefon from licitatie l) `;
   
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('adminPage',{nume:username, data:result});
            });
        }else{
            res.render('loginAdmin');
        }
    });
    
    app.get('/adminPage/adaugaModel',function(req,res){
        if(connect2){
            let qr = `select p.nume as nume_proprietar, p.prenume as prenume_prorietar, c.nume as cumparator_nume , c.prenume as cumparator_prenume, oferta `+
            `from licitatie l `+
            `join telefon t on t.id_telefon = l.id_telefon ` +
            `join users p on p.id_user = t.id_proprietar ` +
            `join users c on l.id_cumparator = c.id_user`
   
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('adaugaModel',{nume:username, data:result});
            });
        }else{
            res.render('loginAdmin');
        }
    });

    app.post('/adminPage/adaugaModel',urlencodedParser,function(req,res){
        let data = req.body;
        let qr = `insert into model_telefon (nume_model,model_procesor,marime_ecran,camera,memorie_ram,memorie,sistem_operare,capacitate_baterie,data_lansare)` +
                    ` values ('${data.nume_model}', '${data.model_procesor}','${data.marime_ecran}','${data.camera}', '${data.memorie_ram}','${data.memorie}', '${data.sistem_operare}',`+
                `'${data.capacitate_baterie}', '${data.data_lansare}')`;
        
        con.query(qr, function (err, result) {
            if (err) throw err;
             console.log("1 record inserted");
             res.redirect('http://localhost:3000/adminPage')
        });
    })

    app.get('/adminPage/stergeStare',function(req,res){
        if(connect2){
            let qr = `select * from status`
   
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('stergeStare',{nume:username, data:result});
            });
        }else{
            res.render('loginAdmin');
        }
    });

    app.post('/adminPage/stergeStare',urlencodedParser,function(req,res){
        data = req.body;
        let qr = `delete from status where id_status = '${data.id_status}'`
        
        con.query(qr, function (err, result) {
            if (err) throw err;
             res.redirect('http://localhost:3000/adminPage/stergeStare')
        });
    })


    app.get('/singup',function(req, res){
        if(connect){
            res.redirect('http://localhost:3000')
        }else{
            res.render('singup');
        }
    })

    app.post('/singup',urlencodedParser,function(req,res){
        let today = new Date();
        let date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        data = req.body;
        let qr = `insert into users (nume,prenume,mail,nr_telefon,adresa,parola,data_inregistrare,status_user)` +
                    `values ('${data.nume}', '${data.prenume}','${data.email}', '${data.nr_telefon}','${data.adresa}',`+
                `'${data.parola}', '${date}', '${1}')`;
        
        con.query(qr, function (err, result) {
            if (err) throw err;
             console.log("1 record inserted");
             res.redirect('http://localhost:3000/profile')
             username = data.email;
             connect = true;
        });
    })
    app.get('/profile',function(req,res){
        if(connect){
            let qr = `select * `+
                     `from users `+
                     `where mail = '${username}'`;
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('profile' ,{data:result[0]});
            });
        }else{
           res.redirect('http://localhost:3000/login')
        }
    });

    app.post('/profile',urlencodedParser,function(req,res){
        let data = req.body;
        let qr = `update users `+
                 `set nume = '${data.nume}' , prenume = '${data.prenume}',mail = '${data.mail}', `+
                 `nr_telefon = '${data.nr_telefon}', adresa = '${data.adresa}', parola = '${data.parola}' `+
                 `where mail = '${data.mail}'`;
        
        con.query(qr, function (err, result) {
            if (err) throw err;
             console.log("1 record updated");
             res.redirect('http://localhost:3000/profile')
        });
    })

    app.get('/profile/telefon',function(req,res){
        if(connect){
            let qr = `select nume_model `+
                     `from model_telefon `+
                     `join telefon on model_telefon.id_model = telefon.id_telefon `+
                     `join users on users.id_user = telefon.id_proprietar ` +
                     `where mail = '${username}';`
            con.query(qr,function(err, result, fields){
                if(err) throw err;
                console.log(result)
                res.render('qs' ,{data:result});
            });
        }else{
           res.redirect('http://localhost:3000/login')
        }
    });

    app.get('/telefon/:id', function(req,res){
        if(connect){
            let qr =  `select P.nume, P.prenume,P.mail, M.nume_model, M.model_procesor, M.marime_ecran, M.camera, M.memorie_ram, M.memorie, M.sistem_operare, M.capacitate_baterie, T.imagine, T.pret_initial, T.id_telefon `+
                      `from model_telefon M `+
                      `join telefon T on T.id_model = M.id_model `+
                      `join users P on T.id_proprietar = P.id_user `+
                      `where T.id_telefon = '${req.params.id}';`;

            con.query(qr,function(err, result, fields){
                if(err) throw err;
                res.render('telefon' ,{data:result[0],username:username});
                console.log(`${result[0].mail} = ${username}`)
            });
        }else{
            res.redirect('http://localhost:3000/login')
        }
    })

    app.post('/telefon/:id',urlencodedParser,function(req,res){
        let data = req.body;
        let qr = `update telefon `+
                 `set pret_initial = '${data.pret}' `+
                 `where id_telefon = '${data.id_telefon}'`
        
        con.query(qr, function (err, result) {
            if (err) throw err;
             console.log("1 record updated");
             res.redirect('http://localhost:3000')
        });
    })
    
}


