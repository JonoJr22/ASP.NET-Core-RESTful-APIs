using BikeStores.API.Domain.Communication;
using BikeStores.API.Domain.Models.Request;
using BikeStores.API.Domain.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace BikeStores.API.Domain.Services
{
    public interface IBrandService
    {
        Task<Response<IEnumerable<BrandResponseModel>>> ListAsync();
        Task<Response<BrandResponseModel>> SaveAsync(BrandRequestModel brand);
        Task<Response<BrandResponseModel>> UpdateAsync(int id, BrandRequestModel brand);
    }
}
