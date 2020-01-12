using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.IO;
using Newtonsoft.Json.Linq;
using System.Net.Http;

namespace slave.Controllers
{
	public class HomeController : Controller
	{
		private async Task broadcast(string script_name){

            using var client = new HttpClient();

            var hosts_file = "slavelist.txt";
            var hosts = System.IO.File.ReadLines(hosts_file);

            foreach(var line in hosts){
                try{
                    Console.WriteLine("Running script {0} on host {1}", script_name, line);
                    var query = String.Format("{0}/get/?fname={1}", line, script_name);
                    var result = await client.GetAsync(query);
                    Console.WriteLine("Script successfully executed!");
                } catch (Exception e) {
                    Console.WriteLine("An error has occured: {0}", e);
				}
			}
		}


		public ActionResult Index(){
			return NotFound();
		}

		[Route("/")]
		[HttpPost]
		public async Task<IActionResult> Index (JObject payload)
		{

			var repo = payload["repository"];
            var name = (string) repo["name"];
			
			await broadcast(name);

			return Ok();
		}
	}
}