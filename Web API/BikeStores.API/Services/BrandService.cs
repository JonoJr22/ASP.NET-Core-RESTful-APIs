using BikeStores.API.Domain.Communication;
using BikeStores.API.Domain.Models.Request;
using BikeStores.API.Domain.Models.Response;
using BikeStores.API.Domain.Services;
using BikeStores.API.Domain.Utilities;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
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

        public async Task<SaveResponse<BrandResponseModel>> SaveAsync(BrandRequestModel brand)
        {
            try
            {
                var brandJSON = JsonConvert.SerializeObject(brand);

                var parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("@pjBrand", brandJSON));

                var data = await _databaseUtility.ExecuteStoredProcedureAsync<BrandResponseModel>("SaveBrand", parameters);
                var result = new SaveResponse<BrandResponseModel>(data.First());

                return result;
            }
            catch (Exception ex)
            {
                var result = new SaveResponse<BrandResponseModel>($"An error occured when saving the brand: {ex.Message}");

                return result;
            }
        }
    }
}
