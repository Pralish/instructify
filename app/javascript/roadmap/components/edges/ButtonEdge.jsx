import React, { useCallback } from 'react';
import { useStore, BaseEdge, EdgeLabelRenderer, getSmoothStepPath } from 'reactflow';

export default function ButtonEdge({
  source,
  target,
  sourceX,
  sourceY,
  targetX,
  targetY,
  sourcePosition,
  targetPosition,
  style = {},
  markerEnd,
  data
}) {
  const [edgePath, labelX, labelY] = getSmoothStepPath({
    sourceX,
    sourceY,
    sourcePosition,
    targetX,
    targetY,
    targetPosition,
  });

  const baseUrl = `/admin/roadmaps/${data.roadmap_id}/nodes/new?parent_id=${data.source_id}&child_id=${data.target_id}`
  return (
    <>
      <BaseEdge path={edgePath} markerEnd={markerEnd} style={style} />
      <EdgeLabelRenderer>
        <div
          style={{
            position: 'absolute',
            transform: `translate(-50%, -50%) translate(${labelX}px,${labelY}px)`,
            fontSize: 12,
            // everything inside EdgeLabelRenderer has no pointer events by default
            // if you have an interactive element, set pointer-events: all
            pointerEvents: 'all',
          }}
          className="nodrag nopan"
        >
          <a data-turbo-frame="offcanvas" className='add-new edgebutton position-absolute d-flex justify-content-center' href={`${baseUrl}`}>
            <i className="bi bi-plus-square" cursorshover="true"></i>
          </a>
        </div>
      </EdgeLabelRenderer>
    </>
  );
}