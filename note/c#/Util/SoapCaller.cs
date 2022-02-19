#region << 版本注释 - v1 >>
/*
 * ========================================================================
 * 版本：v1
 * 时间：181026
 * 作者：Lith   
 * Q  Q：755944120
 * 邮箱：litsoft@126.com
 * 
 * ========================================================================
*/
#endregion

using FrameWork.Net;
using FrameWork.Util;
using Newtonsoft.Json.Linq;
using System.Collections;
using System.Linq;
using System.Text;

namespace UserCard.Model.Common.Util
{
    public class SoapCaller
    {

        public static string  CallSoap12(string url,string actionName, IDictionary param)
        {
            #region Soap12格式
            /*
POST /CallServiceSoapClientJHWR.asmx HTTP/1.1
Host: localhost
Content-Type: application/soap+xml; charset=utf-8
Content-Length: length

<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <DoTrans xmlns="http://tempuri.org/">
      <transCode>string</transCode>
      <inJsonString>string</inJsonString>
    </DoTrans>
  </soap12:Body>
</soap12:Envelope>            
             */
            #endregion

            JObject joReq;

            #region (x.1)构建格式
            joReq = JObject.Parse(@"{
  ""Declaration"": {
    ""version"": ""1.0"",
    ""encoding"": ""utf-8""
  },
  ""Children"": [
    {
      ""Tag"": ""soap12:Envelope"",
      ""Attribute"": {
        ""xmlns:xsi"": ""http://www.w3.org/2001/XMLSchema-instance"",
        ""xmlns:xsd"": ""http://www.w3.org/2001/XMLSchema"",
        ""xmlns:soap12"": ""http://www.w3.org/2003/05/soap-envelope""
      },
      ""Children"": [
        {
          ""Tag"": ""soap12:Body"",
          ""Children"": [ ]            
        }
      ]
    }
  ]
}");
            #endregion

            #region (x.2)添加参数            
            var joBody = joReq["Children"][0]["Children"][0]["Children"].Value<JArray>();
            var joAction = new JObject();
            var joActionParam = new JArray();
            joAction["Tag"] = actionName;
            joAction["Attribute"] = new JObject { ["xmlns"] = "http://tempuri.org/" };
            joAction["Children"] = joActionParam;
            joBody.Add(joAction);

            if (null != param)
            {                
                var retdd =   from DictionaryEntry  item in param                              
                              select new JObject { ["Tag"]= ""+item.Key,["Children"]=new JArray { ("" + item.Value) } };
                retdd.Foreach( item=> joActionParam.Add(item) );
            }
            #endregion

            string xmlResponse;
            #region (x.3)转换格式发送请求
            //发送ajax请求调用 ajax
            xmlResponse = new HttpUtil().Ajax<string>(new RequestParam
            {
                url = url ,
                requestContentType = "application/soap+xml; charset=utf-8",
                Method = "POST",               
                bodyParameters = XmlObject.BuildXmlString(joReq),
                requestEncoding = Encoding.UTF8
            });
            #endregion

            return xmlResponse;
        }

        public static JObject CallSoap12_Jo(string url, string actionName, IDictionary param)
        {
            var xmlRet = CallSoap12(url,actionName,param);
            return XmlObject.FromXmlString(xmlRet);
        }

        

       

    }
}
