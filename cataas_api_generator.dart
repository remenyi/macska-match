import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    inputSpecFile: 'https://cataas.com/doc.json',
    generatorName: Generator.dio,
    outputDirectory: './api/cataas_api')
class CatAASApiGenerator extends OpenapiGeneratorConfig {}