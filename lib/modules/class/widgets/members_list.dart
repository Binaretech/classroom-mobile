part of '../section_view.dart';

class _MembersList extends StatefulWidget {
  final int sectionId;
  final ClassRepository _repository;

  _MembersList({Key? key, required this.sectionId, ClassRepository? repository})
      : _repository = repository ?? ClassRepository(),
        super(key: key);

  @override
  MembersListState createState() => MembersListState();
}

class MembersListState extends State<_MembersList> {
  final List<SectionMember> _members = [];

  final ScrollController _scrollController = ScrollController();

  int page = 1;

  @override
  void initState() {
    super.initState();

    _fetchMembers(page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _fetchMembers(page);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchMembers([int page = 1]) {
    widget._repository.getMembers(widget.sectionId, page).then((members) {
      if (members.data.isEmpty) return;

      setState(() {
        page++;
        _members.addAll(members.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      itemCount: _members.length,
      itemBuilder: (context, index) {
        final member = _members[index];

        return ListTile(
          title: Text(member.fullName),
          subtitle:
              Text(lang.trans("attributes.${member.type}", capitalize: true)),
          leading: UserAvatar(user: member),
        );
      },
    );
  }
}
