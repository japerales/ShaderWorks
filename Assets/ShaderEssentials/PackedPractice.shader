Shader "Holistic/ShaderNotes" {
  
  Properties {
       _myColour ("Example Colour", Color) = (1,1,1,1)
  }
  
  SubShader {
    
    CGPROGRAM
      #pragma surface surf Lambert

      struct Input {
        float2 uvMainTex;
      };

  //smearing: poner el mismo valor para todo el packed array:
  fixed4 _Color = 1;
  //swizzling: poner los indices en diferente orden:
  //_Color.gbr = 1;
  fixed4 _myColour;
  
  //Matrix
  float4x4 matrice;
  //acceso
  //float matrice.m01; //accede a la fila 0, columna 1.


  //chaining:
  //fixed4 colour = matrice.m00_m01_m02_m03; //pasamos la fila 0 (4 valores) encadenando.
  //fixed4 colour2 = matriz[0]; //pasamos toda la fila de golpe.


      void surf (Input IN, inout SurfaceOutput o){
          o.Albedo.rg = _myColour.xy;
      }
    
    ENDCG
  }
  
  FallBack "Diffuse"
}

