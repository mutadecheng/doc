<%@ Page Language="C#" Debug="true" Trace="false" ValidateRequest="false" %>

<!DOCTYPE html  >
<html>
<head>

    <title>FileDownload.aspx V1[Lith 180929 11:55]</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            string fileAllPath = Request["filePath"];
            if (string.IsNullOrEmpty(fileAllPath)) return;

            if (!System.IO.Path.IsPathRooted(fileAllPath))
            {
                fileAllPath = Server.MapPath("~/" + fileAllPath);
            }

            Response.ContentType = "application/x-zip-compressed";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + System.IO.Path.GetFileName(fileAllPath));
            Response.TransmitFile(fileAllPath);
        }
    </script>
</head>
<body>
    <form runat="server">
        <div>
            <input type="submit" />
        </div>         
        filePath: 可为相对路径或者绝对路径。例 "FileDownload.aspx"  "D:\\Code\run.exe"
        <div> 
            <textarea runat="server" id="filePath" rows="1" cols="150"  >FileDownload.aspx</textarea>
        </div>        
    </form>
</body>
</html>

