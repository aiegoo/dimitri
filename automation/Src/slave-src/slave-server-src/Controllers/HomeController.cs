using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.IO;

namespace slave.Controllers
{
	public class HomeController : Controller
	{

		[Route("/")]
		public ActionResult Index (){
			return NotFound();
		}

		[STAThread]
		[Route("/get/")]
		[HttpGet]
		public ActionResult get ()
		{
			string filename = HttpContext.Request.Query["fname"];

			try{

				string path = String.Format("scripts/{0}", filename);

				Process.Start(path);
				return Content ("Success!");

			} catch (Exception e){
				string err = String.Format ("An error has occured: {0}", e);
				return Content (err);
			}
		}
	}
}