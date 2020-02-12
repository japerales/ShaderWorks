Shader "Holistic/CutOff"
{
    Properties
    {
		_Diffuse("Diffuse Texture", 2D) = "white" {}
		_StripesPerUnit("Stripes Per Unit", Range(0.1,20)) = 2
		_RimPower("Rim Power", Range(0.01,10)) = 2
    }
    SubShader
    {
       
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
			float2 uv_Diffuse;
			float3 viewDir;
            float3 worldPos;
        };
		sampler2D _Diffuse;
		half _StripesPerUnit;
		half _RimPower;
	
        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = tex2D(_Diffuse, IN.uv_Diffuse).rgb * 2;
			half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			half rimPowered = pow(rim, _RimPower);
			/*frac se queda con la parte decimal del valor que devuelve la función*/
			/*Para este caso: cuanto mayor es el multiplicador _StripesPerUnit, más pequeñas son las franjas, debido a que la multiplicación
			hace los valores más grandes y por tanto, "pasan" más veces por el rango decimal 0.0-0.99. Ejemplo:
			Si dejamos el multiplicador a 1:
			IN.WorldPos
			1.0 --> 0.0 > 0.4? Rojo
			1.1 --> 0.1 > 0.4? Rojo
			1.2 --> 0.2 > 0.4? Rojo
			1.3 --> 0.3 > 0.4? Rojo
			1.4 --> 0.4 > 0.4? Rojo
			1.5 --> 0.5 > 0.4? Verde
			1.6 --> 0.6 > 0.4? Verde
			1.7 --> 0.7 > 0.4? Verde
			1.8 --> 0.8 > 0.4? Verde
			1.9 --> 0.9 > 0.4? Verde

			Si ponemos el multiplicador a 5
			IN.WorldPos * 5
			1.0 * 5--> 5.0, 0.0 > 0.4? Rojo
			1.1 * 5--> 5.5, 0.5 > 0.4? Verde
			1.2 * 5--> 6.0, 0.0 > 0.4? Rojo
			1.3 * 5--> 6.5, 0.5 > 0.4? Verde
			1.4 * 5--> 7.0, 0.0 > 0.4? Rojo
			1.5 * 5--> 7.5, 0.5 > 0.4? Verde
			1.6 * 5--> 8.0, 0.0 > 0.4? Rojo
			1.7 * 5--> 8.5, 0.5 > 0.4? Verde
			1.8 * 5--> 9.0, 0.0 > 0.4? Rojo
			1.9 * 5--> 9.5, 0.5 > 0.4? Verde
			*/
			o.Emission = frac(IN.worldPos.y*_StripesPerUnit)>0.4? float3(0, 1, 0) *rimPowered : float3(1,0,0)*rimPowered;
			/*El negro en emission es desactivar esta*/
        }
        ENDCG
    }
    FallBack "Diffuse"
}
