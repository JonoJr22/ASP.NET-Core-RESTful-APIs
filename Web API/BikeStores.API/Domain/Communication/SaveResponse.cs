using BikeStores.API.Domain.Models.Response;
using System.ComponentModel;
using System.Linq;
using System.Reflection;

namespace BikeStores.API.Domain.Communication
{
    public class SaveResponse<T>
    {
        public bool Success { get; private set; }
        public string Message { get; private set; }
        public T Data { get; private set; }

        private SaveResponse(bool success, string message, T data)
        {
            Success = success;
            Message = message;
            Data = data;
        }

        // Create a success response
        public SaveResponse(T data) : this(true, string.Empty, data) { }

        // Create an error response
        public SaveResponse(string message) : this(false, message, default) { }

    }
}
