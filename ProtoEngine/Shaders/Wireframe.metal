//
//  Wireframe.metal
//  ProtoEngine
//
//  Created by Milton Montiel on 20/09/25.
//

#include <metal_stdlib>
using namespace metal;
#import "Shaders.h"

fragment float4 wireframe_fragment_main(
                              constant Params &params [[buffer(ParamsBuffer)]],
                              constant Light *lights [[buffer(LightBuffer)]],
                              VertexOut in [[stage_in]],
                              constant Material &_material [[buffer(MaterialBuffer)]],
                              texture2d<float> baseColorTexture [[texture(BaseColor)]]
                              ) {
    return float4(1,1,0, 1);
}
