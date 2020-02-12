Shader "Holistic/StandarPBR"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic Tex(R)", 2D) = "white" {}
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        
        #pragma surface surf Standard

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MetallicTex;
		half _Metallic;
		fixed4 _Color;

        struct Input
        {
            float2 uv_MetallicTex;
        };

     

      
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = _Color.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
			o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
