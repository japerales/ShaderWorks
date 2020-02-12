Shader "Holistic/BumpDiffuse" 
{
    Properties {
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
		_myNormal("Normal Map Texture", 2D) = "bump" {}
		_mySlider("Bump Amount", Range(0,10)) = 1
		_myUVSlider("Scale Size", Range(0.5,10)) = 1
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _myDiffuse;
		sampler2D _myNormal;
		half _mySlider; //half para sliders y valores de properties
		half _myUVSlider; //half para sliders y valores de properties
        struct Input {
            float2 uv_myDiffuse;
			float2 uv_myNormal;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse/_myUVSlider).rgb;
			o.Normal = UnpackNormal(tex2D(_myNormal, IN.uv_myNormal/ _myUVSlider)); //podemos usar las mismas uv del diffuse si queremos...
			/*Los normal maps se comprimen como DXT1, comprimiendo todos los bits de información 
			del normal map. El canal b se pierde y debe recrearse por medio de los otros dos canales (al ser normales se puede).
			De los canales r y g se trata de guardar toda la información posible.
			https://forum.unity.com/threads/unpacknormal-fixed4-packednormal-role.101163/
			https://forum.unity.com/threads/normal-maps-and-importing-them-correctly.82652/#post-629189
			*/
			o.Normal *= float3(_mySlider, _mySlider, 1);
			/*¿Por qué configuramos así el aumento de "bump"? La razon es que si aumentamos z también, lo que obtenemos es el mismo vector normalizado
			multiplicado por el slider, que es un escalar... Pero al normal map le da igual el módulo o magnitud del vector. Solo interpreta la luz en función
			de la inclinación del vector normal. Cuanto más inclinamos el vector, más exagerado será el efecto del bump, un efecto que se notará con todos los
			pixeles adyacentes en conjunto. Una de las formas más sencillas de conseguirlo aumentar en rg su longitud manteniendo z en 1. Con esto conseguimos el vector 
			cada vez más inclinado en la misma dirección si el slider afecta de la misma forma a ambos componentes, x e y.*/
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
