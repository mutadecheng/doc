# Sers΢�����������-02.���ٽ���  
  ΢��������ǵĵ�һӳ���Ǽܹ������Ӵ󣬲��������ǳ��鷳����ʵ������ˣ���ͬ�ļܹ�ѡ�ͱ�Ȼ������ͬ���ŵ��ȱ�㣬û��һ�����ݵķ��������ü�����Ϊ�������ض��Ĺ��ܳ���������Ŀ���Ʒ��ʵ�ʿ�������������ʱ����ƽ���Ҫʵ�ֲ�ͬ�����Ĺ��ܣ����¼ܹ���չ����ʹ����Խ��Խ���ӡ�  
�����������֮ǰ�Ĵ���û��ʹ��΢�����������Ų�ƷҪ������Ҫ�����Ҫʹ��΢������ô�죿�ܹ�Ǩ����һ���ܺ�ʱ���������飬�������һ�׼���΢���񷽰����ܹ������ԭʼ��������޸ļ��ɽ���΢����Ǩ�ƾͺ��ˡ�  
����Sers����������һ�׷�����Sers΢������һ�����Ļ���΢����ܹ�������ͽ���ǳ��򵥡�

����Sers�ṩ��3��c#����ķ�ʽ���û�����Զ�����룩��Serslot�Ƕ�net core web api��ԭ��֧�֡������޸�ԭ��web api���룬�޸�3���ط�����һ�����룩�����޷���롣[���Ҳ鿴Դ��](https://github.com/sersms/sersms.github.io/tree/master/code/SerslotDemo2.1.1.250)��[��������Դ��](https://sersms.github.io/file/demo/SerslotDemo2.1.1.250.zip)��

## 1.���nuget������
>�༭csproj�ļ���������´��룬ͨ��nuget��װSerslot

```xml
<ItemGroup>
	<PackageReference Include="Sers.Serslot" Version="2.1.7" />
</ItemGroup>
```

## 2.�޸���Ŀ��������
>�༭Program.cs�ļ�����������������д���

```csharp
// Program.cs
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Vit.Extensions;   //----��Ӵ���1

namespace SerslotDemo
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseSerslot()  //----��Ӵ���2
                .UseStartup<Startup>();
    }
}

```
 


## 3.���з�������
��������ʹ��net core��д�����Ȱ�װ[netcore2.1���л���](https://sersms.github.io/?md/����Sers΢����/0.1windows��װnetcore2.1���л���.md)��
>windows��װ[netcore2.1](https://dotnet.microsoft.com/download/dotnet/2.1) ���л����ܼ򵥣�����[��װ��](https://download.visualstudio.microsoft.com/download/pr/0d291e03-45d3-441e-8368-9e4b9ab183b4/b93203d22edecfcb17b6b479b54491df/dotnet-sdk-2.1.816-win-x64.exe) ���а�װ���ɡ�


�������windows�����У�����ֱ�����ط������ĳ���Ȼ�����С�
����[�������ĳ����ļ�](https://sersms.github.io/file/Sers/Sers2.1.1.250/SersPublish2.1.1.250.zip)����ѹ��˫���ļ����е��������ļ���01 ServiceCenter.bat�����ɡ�

����̨������������������������������ɹ���
```
[INFO][14:57:33.9310][WebHost]will listening on: http://*:4580
[INFO][14:57:33.9323][WebHost]wwwroot : ......\wwwroot
Hosting environment: Production
Content root path: ......\Sers2.1.1.250\ServiceCenter
Now listening on: http://[::]:4580
Application started. Press Ctrl+C to shut down.
```

 ## 5.���г���
 ���г����ڷ������ĵĿ���̨����������������������ɹ�
 
 ```
[INFO][15:32:51.3471][CL] OnConnected,connTag:
[INFO][15:32:51.5732][ApiCenterService]Regist serviceStation,stationName:
[INFO][15:32:51.5744][ApiCenterService]Add ApiNode,serviceKey:/api/Values/*_DELETE
[INFO][15:32:51.5820][ApiCenterService]Add ApiNode,serviceKey:/api/Values_GET
[INFO][15:32:51.5832][ApiCenterService]Add ApiNode,serviceKey:/api/Values/*_GET
[INFO][15:32:51.5855][ApiCenterService]Add ApiNode,serviceKey:/api/Values_POST
[INFO][15:32:51.5870][ApiCenterService]Add ApiNode,serviceKey:/api/Values/*_PUT
```
 
 �򿪵�ַ <http://localhost:4580/api/Values>,�õ����·��أ�
 ```json
["value1","value2"]
```
 ˵�����ǵ�apiע�ᵽ�������ģ������ɹ������ˡ�
 









 