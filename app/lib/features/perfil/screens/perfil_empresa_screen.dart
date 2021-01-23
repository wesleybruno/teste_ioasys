import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:teste_selecao/features/perfil/model/perfil_empresa_model.dart';
import 'package:teste_selecao/features/perfil/screens/bloc/perfil_empresa_cubit.dart';
import 'package:teste_selecao/injection_container.dart';
import 'package:teste_selecao/widgets/cached_image/cached_image.dart';
import 'package:teste_selecao/widgets/custom_loading/custom_loading.dart';
import 'package:teste_selecao/widgets/error_widgets/erro_api_widget.dart';
import 'package:teste_selecao/widgets/error_widgets/sem_internet_widget.dart';

class PefilEmpresaScreen extends StatefulWidget {
  @override
  _PefilEmpresaScreenState createState() => _PefilEmpresaScreenState();
}

class _PefilEmpresaScreenState extends State<PefilEmpresaScreen> {
  int empresaId;
  PerfilEmpresaCubit cubit;

  @override
  void initState() {
    cubit = dependencia<PerfilEmpresaCubit>();
    cubit.buscarById(empresaId);
    super.initState();
  }

  _recarregar(BuildContext context) {
    BlocProvider.of<PerfilEmpresaCubit>(context).buscarById(empresaId);
  }

  @override
  Widget build(BuildContext context) {
    empresaId = Sailor.param<int>(context, 'enterprise_id');
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<PerfilEmpresaCubit, PerfilEmpresaState>(
        builder: (context, state) {
          if (state is LoadingState)
            return Expanded(
              child: Center(
                child: CustomLoading(),
              ),
            );

          if (state is NoInternet)
            return Expanded(
              child: Center(
                child: SemInternetWidget(
                  aoApertarTentarNovamente: () => _recarregar(context),
                ),
              ),
            );

          if (state is ApiError)
            return ErroApiWidget(
              aoApertarTentarNovamente: () => _recarregar(context),
            );

          if (state is DadosCarregadosState)
            return _buildContent(state.enterpriseModel);

          return Container();
        },
      ),
    );
  }

  _buildContent(PerfilEmpresaModel perfilEmpresaModel) {
    return Column(
      children: [
        Container(
          child: CachedImage(
            imageUrl:
                'https://empresas.ioasys.com.br/uploads/enterprise/photo/1/240.jpeg',
          ),
        ),
        Center(
          child: Text('PerfilEmpresa '),
        ),
      ],
    );
  }
}
