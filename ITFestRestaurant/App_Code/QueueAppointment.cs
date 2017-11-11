using Newtonsoft.Json;

namespace ITFestRestaurant
{
    public class QueueAppointment
    {

        [JsonProperty("date")]
        public string date { get; set; }

        [JsonProperty("email")]
        public string email { get; set; }

        [JsonProperty("message")]
        public string message { get; set; }
    }
}