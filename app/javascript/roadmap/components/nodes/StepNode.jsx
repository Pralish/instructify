import React from 'react';
import { Handle, Position } from 'reactflow';

// TODO: Refactor
// TODO: Merge Stepnode and Tasknode into simple component. Most of the things are similar, so we do not need two separate components
export default function StepNode({ type, data, isConnectable }) {
  const baseUrl = isConnectable ? `/admin/roadmaps/${data.roadmap_id}/nodes` : `/roadmaps/${data.roadmap_id}/nodes`

  return (
    <div className='roadmap__node'>
      <a data-turbo-frame="offcanvas" href={`${baseUrl}/${data.id}${isConnectable ? '/edit' : ''}`} className={`roadmap__node__content-${type.toLowerCase()} text-decoration-none link-secondary`}>
        <div className="roadmap__title--md text-center text-white fs-6">{data.title}</div>
      </a>
      {isConnectable &&
        <div className="d-flex actions position-absolute gap-2">
          <a data-turbo-frame="offcanvas" href={`${baseUrl}/${data.id}/edit`}>
            <i className="bi bi-pencil-square" cursorshover="true"></i>
          </a>
          <a data-turbo-method="delete" data-turbo-confirm="Are you sure?" rel="nofollow" data-method="delete" href={`${baseUrl}/${data.id}`}>
            <i className="bi bi-trash"></i>
          </a>
        </div>
        }
        {!data.has_children && isConnectable && type == 'Step' &&
          <a data-turbo-frame="offcanvas" className='add-new position-absolute d-flex justify-content-center' href={`${baseUrl}/new?parent_id=${data.id}`}>
            <i className="bi bi-plus-square" cursorshover="true"></i>
          </a>
        }
      <Handle type="source" position={Position.Top} id="top" isConnectable={isConnectable}/>
      <Handle type="source" position={Position.Bottom} id="bottom" isConnectable={isConnectable}/>
      <Handle type="source" position={Position.Left} id="left" isConnectable={isConnectable}/>
      <Handle type="source" position={Position.Right} id="right" isConnectable={isConnectable}/>

      <Handle type="target" position={Position.Top} id="top" isConnectable={isConnectable}/>
      <Handle type="target" position={Position.Bottom} id="bottom" isConnectable={isConnectable}/>
      <Handle type="target" position={Position.Left} id="left" isConnectable={isConnectable}/>
      <Handle type="target" position={Position.Right} id="right" isConnectable={isConnectable}/>
    </div>
  );
}