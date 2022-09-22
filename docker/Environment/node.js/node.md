
#-------------------------------------------
# node使用websocket
> https://www.npmjs.com/package/isomorphic-ws
cd /root/main
npm i isomorphic-ws ws


cd /root/main
node /root/main/main.js







#-------------------------------------------
#执行bash
var process = require('child_process');

 
process.exec('ifconfig', function(error, stdout, stderr) {
    console.log("error:"+error);
    console.log("stdout:"+stdout);
    console.log("stderr:"+stderr);
});


var stdout=process.spawnSync('ifconfig', []).stdout.toString();
console.log("stdout:"+stdout);



var stdout=process.execSync('ifconfig', []).toString();
console.log("stdout:"+stdout);




#-------------------------------------------
# nodejs使用serialport
> https://serialport.io/docs/guide-installation
> https://codeload.github.com/serialport/node-serialport/zip/refs/heads/master


#Installing SerialPort
npm install serialport











