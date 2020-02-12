Shader "Holistic/UsePropertiesChallenge3"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}  
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
			
        };

		

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			fixed4 green;
			green.rgba = fixed4(0,1,0,1);
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * green;
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
