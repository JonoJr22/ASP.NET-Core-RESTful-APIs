using BikeStores.API.Domain.Models.Response;
using BikeStores.API.Domain.Services;
using BikeStores.API.Domain.Utilities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace BikeStores.API.Services
{
    public class BrandService : IBrandService
    {
        private readonly IDatabaseUtility _databaseUtility;

        public BrandService(IDatabaseUtility databaseUtility)
        {
            _databaseUtility = databaseUtility;
        }

        public async Task<IEnumerable<BrandResponseModel>> ListAsync()
        {
            var data = await _databaseUtility.ExecuteStoredProcedureAsync<BrandResponseModel>("GetBrands", null);
            return data;
        }
    }
}
