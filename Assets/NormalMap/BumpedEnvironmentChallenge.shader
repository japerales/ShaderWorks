Shader "Holistic/BumpedEnvironment"
{
	Properties{
		_myNormal("Normal Map Texture", 2D) = "bump" {}
		_mySlider("Bump Amount", Range(0,10)) = 1
		_myBright("Brightness", Range(0,10)) = 1
		_myCube("Cube Map", CUBE) = "white" {}
	}
		SubShader{

		  CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _myDiffuse;
			sampler2D _myNormal;
			half _mySlider; //half para sliders y valores de properties
			half _myBright;
			samplerCUBE _myCube;

			struct Input {
				float2 uv_myNormal;
				float3 worldRefl; INTERNAL_DATA
			};

			void surf(Input IN, inout SurfaceOutput o) {
				o.Normal = UnpackNormal(tex2D(_myNormal, IN.uv_myNormal)) * _myBright;
				o.Normal *= float3(_mySlider, _mySlider, 1);
				//emission emite luz, por lo que si reflejamos el entorno damos un efecto cristalino.
				o.Albedo = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
			}

		  ENDCG
		}
			Fallback "Diffuse"
}
