using BikeStores.API.Domain.Communication;
using BikeStores.API.Domain.Models.Request;
using BikeStores.API.Domain.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace BikeStores.API.Domain.Services
{
    public interface ICategoryService
    {
        Task<Response<IEnumerable<CategoryResponseModel>>> ListAsync();
        Task<Response<CategoryResponseModel>> CollectAsync(int id);
        Task<Response<CategoryResponseModel>> SaveAsync(CategoryRequestModel category);
    }
}
