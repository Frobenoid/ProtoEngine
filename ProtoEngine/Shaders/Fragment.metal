//
//  Fragment.metal
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

#include <metal_stdlib>
using namespace metal;
#import "Shaders.h"
#import "Lighting.h"

fragment float4 fragment_main(
                              constant Params &params [[buffer(ParamsBuffer)]],
                              constant Light *lights [[buffer(LightBuffer)]],
                              VertexOut in [[stage_in]],
                              constant Material &_material [[buffer(MaterialBuffer)]],
                              texture2d<float> baseColorTexture [[texture(BaseColor)]]
                              ) {
    Material material = _material;
    constexpr sampler textureSampler(
                                     filter::linear,
                                     mip_filter::linear,
                                     max_anisotropy(8),
                                     address::repeat);
    
    if (!is_null_texture(baseColorTexture)) {
        material.baseColor = baseColorTexture.sample(
                                                     textureSampler,
                                                     in.uv).rgb;
    }
    
    float3 normalDirection = normalize(in.worldNormal);
    float3 color = phongLightint(normalDirection, in.worldPosition, params, lights, material.baseColor);
    
    return float4(color, 1);
}
