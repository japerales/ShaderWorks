Shader "Holistic/RimColorPower"
{
	Properties{


		_RimColor("Rim Color", Color) = (0,0.5,0.5,0)
		_Intensity("Intensity", Range(0.1,10)) = 1
		_CutOut("Cut Out", Range(0,1)) = 1
	}
		SubShader
	{

		CGPROGRAM
		#pragma surface surf Lambert

		float4 _RimColor;
		half _Intensity;
		half _CutOut;
		struct Input
        {
            float3 viewDir; //Si algo depende de la camara del usuario, llamamos a viewDir
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
			/*saturate en este caso no tiene ningun efecto, pero es más limpio, puesto que el dot recordemos que puede dar entre
			1 y -1. Menos de 0 no nos interesa y no tiene efecto sobre el color. Saturate clampea entre 0 y 1*/
			half rim = saturate(1-dot(normalize(IN.viewDir), o.Normal));
			/*Pow: lo primero que debemos tener en cuenta es que cuando hacemos potencia con números entre 0 y 1, los resultados funcionan al revés.
			Es decir, si elevo 0.9 a un numero muy alto, por ejemplo, 10, obtendré un número cercano a cero. Si elevo 0.9 a un número muy bajo, como 0.01, 
			obtendré un número muy cercano a 1.
			A parte, hemos metido un cutout, de forma que si no hay un valor mínimo de rim, se contabilizará 0*/
			o.Emission = _RimColor.rgb * pow(rim>_CutOut?rim:0, _Intensity);

        }
        ENDCG
    }
    FallBack "Diffuse"
}
