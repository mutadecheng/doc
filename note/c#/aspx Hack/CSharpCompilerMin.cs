#region << 版 本 注 释 >>
/*
 * ========================================================================
 * 版本：v1
 * 时间：180929
 * 作者：Lith   
 * Q  Q：755944120
 * 邮箱：litsoft@126.com
 * 
 * ========================================================================
*/
#endregion

 

namespace DynamicCompile
{
    public class CSharpCompilerMin
    {        

        #region Compile

        public static System.Reflection.Assembly Compile(string[] referencedAssemblies,  params string[] sources)
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
}
