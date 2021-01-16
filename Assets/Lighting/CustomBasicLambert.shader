Shader "Custom/BasicLambert"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }

        CGPROGRAM
        // Nombramos al nuevo modelo de iluminacion
        #pragma surface surf BasicLambert

        //hay que nombrar la funcion con la palabra Lighting + nombre modelo de ilum.
        half4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten)
        {
            half NdotL = dot(s.Normal, lightDir);
            half4 c;
            //s.Albedo proviene de la funcion surf.
            //LightColor0 es el color de la luz.
            c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
            c.a = s.Alpha;
            return c;
        }

        fixed4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
          
        }
        ENDCG
    }
    FallBack "Diffuse"
}
