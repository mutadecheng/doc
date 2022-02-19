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

using System;
using Microsoft.CSharp;
using System.CodeDom.Compiler;
using System.Reflection;
using System.IO;

namespace DynamicCompile
{
    public class CSharpCompiler
    {
        

        #region Compile

        public static Assembly Compile(string OutputAssemblyPath ,string[] referencedAssemblies,  params string[] sources)
        {
            // 1.Create a new CSharpCodePrivoder instance
            CSharpCodeProvider codeProvider = new CSharpCodeProvider();

            // 2.Sets the runtime compiling parameters by crating a new CompilerParameters instance
            CompilerParameters param = new CompilerParameters();
            if (null == OutputAssemblyPath)
            {
                param.GenerateInMemory = true;
            }
            else
            {
                param.GenerateInMemory = false;
                param.OutputAssembly = OutputAssemblyPath;
            }


            if (null != referencedAssemblies)
                foreach (string ra in referencedAssemblies)
                    param.ReferencedAssemblies.Add(ra);


            // 3.CompilerResults: Complile the code snippet by calling a method from the provider
            CompilerResults cr = codeProvider.CompileAssemblyFromSource(param, sources);

            if (cr.Errors.HasErrors)
            {
                string strErr = "";
                foreach (CompilerError err in cr.Errors)
                {
                    strErr += "\r\nLine: " + err.Line + " - " + err.ErrorText;
                }
                var e = new Exception(strErr);
                e.Data["CompilerError"] = cr.Errors;
                throw e;                 
            }
            if (null == OutputAssemblyPath) return cr.CompiledAssembly;

            return null;
        }
        #endregion


 

        #region LoadAssemblyInMemory
        public static Assembly LoadAssemblyToMemory(string dllFile)
        { 
            //先将插件拷贝到内存缓冲
            byte[] addinStream = File.ReadAllBytes(dllFile);
            //加载内存中的Dll
            return Assembly.Load(addinStream); 
        }
        #endregion

 

        

    }
}
