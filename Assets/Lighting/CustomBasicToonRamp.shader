Shader "Custom/CustomLightingToon"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _Ramp("Ramp Text", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }

        CGPROGRAM
        // Nombramos al nuevo modelo de iluminacion
        #pragma surface surf ToonRamp

         fixed4 _Color;
        sampler2D _Ramp;

        //hay que nombrar la funcion con la palabra Lighting + nombre modelo de ilum.
        half4 LightingToonRamp(SurfaceOutput s, half3 lightDir, half atten)
        {
            
            half diffuse = max(0, dot(lightDir, s.Normal));

            float h = diffuse * 0.5 + 0.5;
            float2 rh = h;
            //mapping entre los valores de la ramp (horizontales) y ndotL para capturar
            half r = tex2D(_Ramp, rh).rgb;
            
            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * r;
            c.a = s.Alpha;
            return c;
        }

       

        struct Input
        {
            float2 uv_Ramp;
        };

        

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
          
        }
        ENDCG
    }
    FallBack "Diffuse"
}
