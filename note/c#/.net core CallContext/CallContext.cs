using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Yizuan.UserCenter.Entity.Help
{


    /*
     
         
         /// <summary>
        /// 设置插入数据的命令
        /// </summary>
        /// <param name="entity">实体对象</param>
        /// <param name="cmd">命令</param>
        /// <returns>返回真说明要取主键</returns>
        protected sealed override bool SetInsertCommand(CorporationData entity, MySqlCommand cmd)
        {
            cmd.CommandText = InsertSqlCode;
            CreateFullSqlParameter(entity, cmd);
            Yizuan.UserCenter.Entity.Help.CallContext.SetData("DataAccess"+this.GetHashCode(), cmd);
            return false;
        }


        public long InsertAndReturnId(CorporationData entity)
        {
            if (!Insert(entity)) return -1;

            var cmd = Yizuan.UserCenter.Entity.Help.CallContext.GetData("DataAccess" + this.GetHashCode()) as MySqlCommand;
            if (null != cmd)
            {
                Yizuan.UserCenter.Entity.Help.CallContext.SetData("DataAccess" + this.GetHashCode(),null);
                return cmd.LastInsertedId;
            }
            return -2;
        }
         
         
         */

    public static class CallContext
    {
        static ConcurrentDictionary<string, AsyncLocal<object>> state = new ConcurrentDictionary<string, AsyncLocal<object>>();

        public static void SetData(string name, object data) =>
            state.GetOrAdd(name, _ => new AsyncLocal<object>()).Value = data;

        public static object GetData(string name) =>
            state.TryGetValue(name, out AsyncLocal<object> data) ? data.Value : null;

    }
    
}
