using BikeStores.API.Domain.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace BikeStores.API.Domain.Services
{
    public interface IBrandService
    {
        Task<IEnumerable<BrandResponseModel>> ListAsync();
    }
}
