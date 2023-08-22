export const formatedPayload = (data) => {
  return {
    roadmap: {
      nodes_attributes: data.nodes.map((node) => { 
        return {
          position: node.position,
          incoming_edges_attributes: data.edges.filter((edge) => edge.target == node.id),
          ...(node.data)
        }
       })
    }
  }
} 

export function formDataToJson(formData) {
  const jsonData = {};

  formData.forEach((value, key) => {
    const keys = key.split("[");
    let currentObj = jsonData;

    keys.forEach((keyPart, index) => {
      const keyName = keyPart.replace(/\]$/, "");
      if (!currentObj[keyName]) {
        currentObj[keyName] = {};
      }

      if (index === keys.length - 1) {
        currentObj[keyName] = value;
      }

      currentObj = currentObj[keyName];
    });
  });

  return jsonData;
}