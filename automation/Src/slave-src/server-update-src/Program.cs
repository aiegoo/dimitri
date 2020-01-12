using System;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;

namespace server_update
{
    class Program
    {
        static async Task Main(string[] args)
        {

            var script_name = "";

            if(args.Length != 1){
                Console.WriteLine("Script name needed as an argument");
                Environment.Exit(1);
            } else {
                script_name = args[0];
            }

            using var client = new HttpClient();

            var hosts_file = "slavelist.txt";
            var hosts = File.ReadLines(hosts_file);

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
    }
}
