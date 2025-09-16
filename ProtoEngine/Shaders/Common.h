//
//  Common.h
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

#ifndef Common_h
#define Common_h

#import <simd/simd.h>

typedef vector_float3 vec3;
typedef uint32_t uint;

typedef struct {
    matrix_float4x4 modelMatrix;
    matrix_float4x4 viewMatrix;
    matrix_float4x4 projectionMatrix;
    matrix_float3x3 normalMatrix;
} Uniforms;

typedef struct {
    /// MSL doesn't have a dynamic array feature so the need to pass
    /// the number of elements in an array.
    uint lightCount;
    vec3 cameraPosition;

    uint32_t width;
    uint32_t height;
    uint32_t tiling;
    float scaleFactor;
} Params;

typedef enum {
    Position = 0,
    Normal = 1,
    UV = 2,
    Tangent = 3,
    Bitangent = 4
} Attributes;

typedef enum {
    VertexBuffer = 0,
    UVBuffer = 1,
    TangentBuffer = 2,
    BitangentBuffer = 3,
    UniformsBuffer = 11,
    ParamsBuffer = 12,
    LightBuffer = 13,
    MaterialBuffer = 14
} BufferIndices;

typedef enum {
    BaseColor = 0,
    NormalTexture = 1,
    RoughnessTexture = 2,
    MetallicTexture = 3,
    AOTexture = 4,
    SolidColor = 5, 
} TextureIndices;

typedef struct {
    vector_float3 baseColor;
    float roughness;
    float metallic;
    float ambientOcclusion;
} Material;

typedef enum {
    Unused = 0,
    Sun = 1,
    Spot = 2,
    Point = 3,
    Ambient = 4
} LightType;

typedef enum {
    AmbientLight = 0, 
} LightIndex;

typedef struct {
    LightType type;
    vec3 position;
    vec3 color;
    vec3 specularColor;
    float radius;
    vec3 attenuation;
    float coneAngle;
    vec3 coneDirection;
    float coneAttenuation;
} Light;

#endif /* Common_h */
