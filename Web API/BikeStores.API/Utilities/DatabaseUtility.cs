using BikeStores.API.Domain.Utilities;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace BikeStores.API.Utilities
{
    public class DatabaseUtility : IDatabaseUtility
    {
        private readonly string _connectionString;

        public DatabaseUtility(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IEnumerable<T>> ExecuteStoredProcedureAsync<T>(string name, List<SqlParameter> parameters)
        {
            using (SqlConnection sql = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(name, sql))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        foreach (var param in parameters)
                        {
                            cmd.Parameters.Add(param);
                        }
                    }

                    var response = new List<T>();
                    await sql.OpenAsync();

                    using (var reader = await cmd.ExecuteReaderAsync(CommandBehavior.CloseConnection))
                    {
                        response = MapToModel<T>(reader);
                        reader.NextResult();
                    }

                    return response;
                }
            }
        }

        private List<T> MapToModel<T>(SqlDataReader reader)
        {
            var result = new List<T>();
            var type = typeof(T);
            var columns = new List<PropertyInfo>();

            var propInfos = type.GetProperties();

            //Loop through to map columns and properties
            for (int i = 0; i < reader.FieldCount; i++)
            {
                //See if column name maps directly to property name
                var col = propInfos.FirstOrDefault(c => c.Name == reader.GetName(i));
                if (col != null)
                    columns.Add(col);
            }

            while (reader.Read())
            {
                var entity = Activator.CreateInstance<T>();

                for (int i = 0; i < columns.Count; i++)
                {
                    if (reader[columns[i].Name].Equals(DBNull.Value))
                    {
                        columns[i].SetValue(entity, null, null);
                    }
                    else
                    {
                        columns[i].SetValue(entity, reader[columns[i].Name], null);
                    }
                }
                result.Add(entity);
            }

            return result;
        }
    }
}
