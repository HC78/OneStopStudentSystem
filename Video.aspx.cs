using Newtonsoft.Json.Linq;
using System;
using System.Configuration;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;

namespace OneStopStudentSystem
{
    public partial class Video : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected async void SearchAndShowVideo(object sender, EventArgs e)
        {
            string apiKey = ConfigurationManager.AppSettings["YouTubeApiKey"];
            string word = wordInput.Text;
            if (!string.IsNullOrEmpty(word))
            {
                string searchQuery = $"{word} pronunciation";

                string videoId = await FetchYouTubeVideoId(apiKey, searchQuery);

                if (!string.IsNullOrEmpty(videoId))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "showVideo", $"showVideo('{videoId}');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('No pronunciation videos found.');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Please Input WORD');", true);
            }
        }

        private async Task<string> FetchYouTubeVideoId(string apiKey, string searchQuery)
        {
            string apiUrl = $"https://www.googleapis.com/youtube/v3/search?part=snippet&q={searchQuery}&type=video&key={apiKey}";

            using (HttpClient client = new HttpClient())
            {
                HttpResponseMessage response = await client.GetAsync(apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    string json = await response.Content.ReadAsStringAsync();
                    JObject data = JObject.Parse(json);

                    if (data["items"] != null && data["items"].HasValues)
                    {
                        string videoId = data["items"][0]["id"]["videoId"].ToString();
                        return videoId;
                    }
                }
            }

            return null;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            wordInput.Text = string.Empty;
            videoContainer.Controls.Clear();
        }
    }
}
