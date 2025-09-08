//
//  Lighting.h
//  ProtoEngine
//
//  Created by Milton Montiel on 07/09/25.
//

#ifndef Lighting_h
#define Lighting_h

#import "Common.h"

float3 phongLightint(float3 normal, float3 position, constant Params &params,
                     constant Light *lights, float3 baseColor);

#endif /* Lighting_h */
