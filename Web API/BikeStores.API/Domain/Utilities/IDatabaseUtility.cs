using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace BikeStores.API.Domain.Utilities
{
    public interface IDatabaseUtility
    {
        Task<IEnumerable<T>> ExecuteStoredProcedureAsync<T>(string name, List<SqlParameter> parameters);
    }
}
