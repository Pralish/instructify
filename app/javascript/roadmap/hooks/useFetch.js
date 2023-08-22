import { useState, useEffect } from 'react';

function useFetch(url, initialData, options, refetch) {
  const [data, setData] = useState(initialData);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);

  const { method = 'GET', body = '' } = options || {};

  useEffect(() => {
    if (refetch !== null) {
      setLoading(true);
      const request$ = fetch(url, {
        method,
        ...(method !== 'GET' && { body }),
      });

      request$
        .then(async (statusResp) => {
          let resp;
          if (statusResp.ok) {
            resp = await statusResp.clone().json()
            return resp;
          } else {
            throw new Error('Error occured');
          }
        })
        .then((res) => {
          setData(res);
          setError(false);
        })
        .catch(() => {
          setData(null);
          setError(true);
        })
        .finally(() => setLoading(false));
    }
  }, [refetch]);

  return { data, loading, error };
}

export default useFetch;