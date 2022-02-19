#region << 版 本 注 释 >>
/*
 * ========================================================================
 * 版本：3
 * 时间：181012 11:15
 * 作者：Lith   
 * Q  Q：755944120
 * 邮箱：litsoft@126.com
 * 
 * ========================================================================
*/
#endregion


using System;
using System.Drawing;
using System.Drawing.Imaging;

namespace Framework.Util.Drawing
{
    /// <summary>
    /// 提供Base64String 和 Bitmap的相互转化
    /// </summary>
    public class BitmapHelp
    {

        #region Img <--> Base64String


        /// <summary>
        /// 把图像文件转换为base64字符串
        /// </summary>
        /// <param name="imgfilepath"></param>
        /// <param name="format">若不指定则使用原图像文件格式</param>
        /// <returns></returns>
        public static string BitmapToBase64String(Bitmap bmp, ImageFormat format = null)
        {
            //try
            //{
            //    if (null == format)
            //        format = bmp.RawFormat;//.net core 访问RawFormat会抛异常
            //}
            //catch { }
            

            //读图片转为Base64String           
            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                bmp.Save(ms, format ?? ImageFormat.Jpeg);
                byte[] arr1 = new byte[ms.Length];
                ms.Position = 0;
                ms.Read(arr1, 0, (int)ms.Length);

                return Convert.ToBase64String(arr1);
            }
        }



        /// <summary>
        /// 把图像文件转换为base64字符串
        /// </summary>
        /// <param name="imgfilepath"></param>
        /// <param name="format">若不指定则使用原图像文件格式</param>
        /// <returns></returns>
        public static string ImgToBase64String(string imgfilepath, ImageFormat format=null)
        {
            using (var bmp = new System.Drawing.Bitmap(imgfilepath))       
            {
                return BitmapToBase64String(bmp, format);
            }
        }


        /// <summary>
        /// 把base64编码的字符串转为图片
        /// </summary>
        /// <param name="base64String"></param>
        /// <returns></returns>
        public static Bitmap Base64StringToBitmap(string base64String)
        {
            byte[] arr = Convert.FromBase64String(base64String);
            using (var ms = new System.IO.MemoryStream(arr))
            {
                var bmp = new System.Drawing.Bitmap(ms);
                return bmp;
            }
            //using (var bmp = new System.Drawing.Bitmap(ms))
            //{

            //    bmp.Save(Imagefilepath + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            //    //bmp.Save(txtFileName + ".bmp", ImageFormat.Bmp);
            //    //bmp.Save(txtFileName + ".gif", ImageFormat.Gif);
            //    //bmp.Save(txtFileName + ".png", ImageFormat.Png);
            //}
        }
        #endregion
    }
}
