//
//  Fragment.metal
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

#include <metal_stdlib>
using namespace metal;
#import "Shaders.h"
#import "Common.h"

fragment float4 fragment_main(VertexOut in [[stage_in]],
                              texture2d<float> baseColorTexture [[texture(BaseColor)]],
                              constant Material &_material [[buffer(MaterialBuffer)]]
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
                                                     in.uv ).rgb;
    }
    
    return float4(1,0,0,1);
}
