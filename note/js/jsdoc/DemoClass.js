 
 



/**
 * B4C入口类
 * @class
 * @version 1.0.2197
 * @author lith
 * @example
 *  var demo = new DemoClass({ domId: 'be-container' }); 
 *
 */
class DemoClass {


	/** 版本号。例如 1.0.2197。静态成员变量
	 * @memberof DemoClass
     * @constant
	 * @type {string}
	 */
	static version = "1.0.2197";

 
 
 

	/**
	 * 底层对象。成员变量
	 * @type {Cesium.Viewer}
	 */
    viewer;

 

	/**
	 * 构造函数
     * @constructor
	 * @param {string} name 名称
	 * @param {object} config 参数
	 * @param {string} config.domId dom对象id
	 * @param {string} config.name [options] 名称 
	 * @param {Number} [options] age 年龄
	 */
    constructor(name, config,age) {        
    }    


    /**
    * @typedef {Function} addContructor_func
    * @param {B4C} b4c 要初始化的b4c对象
    * @param {Array} args b4c构造函数的参数
    * @example
    *   B4C.addContructor(function(b4c,args){
    *       b4c.alert = function(msg){
    *           alert(msg);
    *       };
    *   },'alert');
    */

	/**
	* 添加对象初始化回调函数。静态函数
	* @param {addContructor_func} func 对象初始化回调函数
	* @param {string} name 回调名称
	* @return {boolean} 是否添加成功。若已经存在同名的回调，则添加失败
    * @example
    *   B4C.addContructor(function(b4c,args){
    *       b4c.alert = function(msg){
    *           alert(msg);
    *       };
    *   },'alert'); 
    * 
	*/
    static addContructor(func, name) {
     
        if (!name) {
            this.constructorArray.push(func);        
            return true;
        }
        if (this.constructorCache[name]) return false;
        this.constructorArray.push(func);
        this.constructorCache[name] = func;
        return true;
    };
};


 
/** 发布时间。例如 2021-04-09。静态成员变量
 * @constant
 * @type {string}
 */
DemoClass.versionTime = "2021-04-09";
 

export { DemoClass };




 



 